extension StringOperation on String {
  toUpperLowerCase(){
    return  isEmpty ? "" : this[0].toUpperCase() + substring(1,length);
  }
}