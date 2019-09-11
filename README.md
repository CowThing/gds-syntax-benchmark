# GDScript Syntax Benchmarks

Speed comparisons of various syntax alternatives within the GDScript language (Godot game engine).  All code is within [benchmarks.gd](benchmarks.gd), including funcs referenced in results table.

## To Run Tests Yourself

* Open the project in Godot
* Click the lone node in the Scene/Node panel
* Click the unchecked box in the Inspector for the exported variable 'Click To Run'
* Wait several seconds for the tests to run (Godot editor may appear frozen during this time)

The script is a 'tool' and clicking this exported variable will trigger a setget function which actually runs the tests.  The results will be printed in the standard output and written to your disk as README.md (clobbering the existing README.md)

## Results

```Godot version: 3.1-stable (official)```

        array_index  ***  56% faster than ***  array_append    (0.235 vs 0.368 sec)
          array_len  ***   3% faster than ***  array_size      (0.223 vs 0.230 sec)
        array_izero  ***  15% faster than ***  array_front     (0.205 vs 0.236 sec)
         array_ineg  ***  11% faster than ***  array_back      (0.220 vs 0.244 sec)
           var_func  ***   6% faster than ***  var_script      (0.169 vs 0.179 sec)
         var_script  ***  32% faster than ***  var_self        (0.176 vs 0.232 sec)
           iter_for  *** 122% faster than ***  iter_while      (0.114 vs 0.253 sec)
                ifs  ***  18% faster than ***  matches         (0.440 vs 0.521 sec)
     array_appendrw  ***  12% faster than ***  parray_appendrw (0.709 vs 0.794 sec)
       dontcallfunc  *** 222% faster than ***  callfunc        (0.114 vs 0.366 sec)
       inteval_auto  ***  55% faster than ***  inteval         (0.156 vs 0.243 sec)
     arrayeval_auto  *** 228% faster than ***  arrayeval       (0.157 vs 0.515 sec)
      dicteval_auto  *** 216% faster than ***  dicteval        (0.158 vs 0.500 sec)
      nulleval_auto  ***  55% faster than ***  nulleval        (0.156 vs 0.242 sec)
