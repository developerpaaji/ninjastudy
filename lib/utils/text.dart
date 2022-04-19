String capitalize(String val) {
  if (val.length <= 1) {
    return val;
  }
  return val.substring(0, 1).toUpperCase() + val.substring(1);
}
