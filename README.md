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

        array_index  ***  45% faster than ***  array_append    (0.266 vs 0.386 sec)
          array_len  ***   1% faster than ***  array_size      (0.231 vs 0.233 sec)
        array_izero  ***  15% faster than ***  array_front     (0.209 vs 0.239 sec)
         array_ineg  ***  11% faster than ***  array_back      (0.221 vs 0.244 sec)
           var_func  ***   4% faster than ***  var_script      (0.171 vs 0.179 sec)
         var_script  ***  32% faster than ***  var_self        (0.181 vs 0.239 sec)
       iter_for_int  ***  24% faster than ***  iter_for_range  (0.335 vs 0.417 sec)
           iter_for  *** 120% faster than ***  iter_while      (0.115 vs 0.254 sec)
                ifs  ***  16% faster than ***  matches         (0.445 vs 0.516 sec)
     array_appendrw  ***  15% faster than ***  parray_appendrw (0.708 vs 0.815 sec)
       dontcallfunc  *** 227% faster than ***  callfunc        (0.113 vs 0.370 sec)
       inteval_auto  ***  54% faster than ***  inteval         (0.156 vs 0.240 sec)
     arrayeval_auto  *** 233% faster than ***  arrayeval       (0.158 vs 0.526 sec)
      dicteval_auto  *** 220% faster than ***  dicteval        (0.159 vs 0.508 sec)
      nulleval_auto  ***  62% faster than ***  nulleval        (0.157 vs 0.255 sec)
