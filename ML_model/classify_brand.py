import tensorflow as tf
from tensorflow.keras import layers, regularizers

import os

# Set this to print out if running on CPU or GPU
# tf.debugging.set_log_device_placement(True)

# Defining some parameters for the training
batch_size = 5
num_classes = 5
epochs = 1

# These class names map to the integer labels based on item position in list.
# Examples: 0 -> 'companyA', 1 -> 'companyB'. Also see labels below.
class_names = [
    'greenwashed_company',
    'sustainable_company',
    'companyA',
    'companyB',
    'companyC'
]

# Specify image files and labels and parse into datasets
fnames_train = tf.constant(['data/train_brands/1_bad-company-logo_scaled.jpg',
                            'data/train_brands/2_good-company-logo_scaled.jpg',
                            'data/train_brands/3_background-company-logo_scaled.jpg',
                            'data/train_brands/4_background-company-logo_scaled.jpg',
                            'data/train_brands/5_background-company-logo_scaled.jpg'])
labels_train = tf.constant([0, 1, 2, 3, 4])
ds_train = tf.data.Dataset.from_tensor_slices((fnames_train, labels_train))

fnames_test = tf.constant(['data/test_brands/1_bad-company-logo_scaled.jpg',
                          'data/test_brands/2_good-company-logo_scaled.jpg'])
labels_test = tf.constant([0, 1])
ds_test = tf.data.Dataset.from_tensor_slices((fnames_test, labels_test))


def _parse_image(filename, label):
    image = tf.io.read_file(filename)
    image = tf.image.decode_jpeg(image, channels=3)
    image = tf.image.convert_image_dtype(image, tf.float16)
    # image = tf.image.resize(image, [250, 250])
    return image, label


ds_train = ds_train.map(_parse_image)
ds_train = ds_train.batch(batch_size)

ds_test = ds_test.map(_parse_image)
ds_test = ds_test.batch(2)

# Design the model
model = tf.keras.models.Sequential([
    layers.experimental.preprocessing.Resizing(300,
                                               300,
                                               interpolation="bilinear",
                                               input_shape=(128, 128, 3)),
    layers.Conv2D(32,
                  (3, 3),
                  kernel_regularizer=regularizers.l2(0.0001),
                  activation='relu'),
    layers.Conv2D(64,
                  (3, 3),
                  kernel_regularizer=regularizers.l2(0.0001),
                  activation='relu'),
    layers.MaxPooling2D(pool_size=(2, 2)),
    layers.Dropout(0.25),
    layers.Flatten(),
    layers.Dense(64,
                 kernel_regularizer=regularizers.l2(0.0001),
                 activation='relu'),
    layers.Dropout(0.5),
    layers.Dense(num_classes)
])

model.summary()

# Define loss function and compile model
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)

model.compile(optimizer='adam',
              loss=loss_fn,
              metrics=['accuracy'])

# Train the model
model.fit(ds_train,
          batch_size=batch_size,
          epochs=epochs)

print(model.evaluate(ds_test, verbose=2))
# model.predict()

# model.save('classify_brand')

# Convert the model.
#converter = tf.lite.TFLiteConverter.from_keras_model(model)
#converter.optimizations = [tf.lite.Optimize.DEFAULT]
#tflite_model = converter.convert()

# Save the TF Lite model.
#with tf.io.gfile.GFile('../assets/classify_brand.tflite', 'wb') as f:
#    f.write(tflite_model)

# Create labels.txt to go along with the TF Lite model
if os.path.exists('../assets/labels.txt'):
    os.remove('../assets/labels.txt')
with open('../assets/labels.txt', 'a') as file:
    for it, label in enumerate(class_names):
        file.write(f'{it} {label}\n')
