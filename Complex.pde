class Complex {
  private float real;
  private float imaginary;

  public Complex(float real, float imaginary) {
    this.real = real;
    this.imaginary = imaginary;
  }

  public Complex() {
    this(0, 0);
  }

  public float getReal() {
    return real;
  }

  public void setReal(float real) {
    this.real = real;
  }

  public float getImaginary() {
    return imaginary;
  }

  public void setImaginary(float imaginary) {
    this.imaginary = imaginary;
  }

  public Complex add(Complex other) {
    return new Complex(this.real + other.real, this.imaginary + other.imaginary);
  }

  public Complex square() {
    return new Complex(real * real - imaginary * imaginary, 2 * real * imaginary);
  }

  public float abs() {
    return (float) sqrt(real * real + imaginary * imaginary);
  }
}