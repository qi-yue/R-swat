#
# Copyright SAS Institute
#
#  Licensed under the Apache License, Version 2.0 (the License);
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.



context("test.graphics.R")

verify_jpeg_pkg <- function () {
   tryCatch({
      library(jpeg)
   }, error = function (e) {
      testthat::skip('"jpeg" library is not installed to compare JPEG files.')
   })
}

test_that("plot.scatter", {
  verify_jpeg_pkg()

  dfplot <- tempfile(fileext='.jpg')
  jpeg(dfplot)
  plot(iris$Sepal.Length, iris$Sepal.Width, xlab='Sepal Length', ylab='Sepal Width')
  dev.off()

  casplot <- tempfile(fileext='.jpg')
  jpeg(casplot)
  plot(i2$Sepal.Length, i2$Sepal.Width, xlab='Sepal Length', ylab='Sepal Width')
  dev.off()

  expect_equal(readJPEG(dfplot), readJPEG(casplot), tolerance=0.018)

  unlink(dfplot)
  unlink(casplot)
})

test_that('plot.bar', {
  verify_jpeg_pkg()

  dfplot <- tempfile(fileext='.jpg')
  jpeg(dfplot)
  plot(iris$Sepal.Length, iris$Sepal.Width, xlab='Sepal Length', ylab='Sepal Width', type='h', col='red', lwd=10)
  dev.off()

  casplot <- tempfile(fileext='.jpg')
  jpeg(casplot)
  plot(i2$Sepal.Length, i2$Sepal.Width, xlab='Sepal Length', ylab='Sepal Width', type='h', col='red', lwd=10)
  dev.off()

  expect_equal(readJPEG(dfplot), readJPEG(casplot), tolerance=0.018)

  unlink(dfplot)
  unlink(casplot)
})
