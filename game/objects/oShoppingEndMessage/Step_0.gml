if (noBags > 0 && variable_global_exists("correctWords") && array_length_1d(global.correctWords) == 0) {
    noBags -= 1;
}
