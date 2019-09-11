# GDScript Syntax Benchmarks

Speed comparisons of various syntax alternatives within the GDScript language (Godot game engine).  All code is within [benchmarks.gd](benchmarks.gd), including funcs referenced in results table.

```Godot version: 3.1-stable (official)```

## Results

        array_index  ***  54% faster than ***  array_append    (0.243 vs 0.376 sec)
         array_size  ***   3% faster than ***  array_len       (0.232 vs 0.239 sec)
        array_izero  ***  14% faster than ***  array_front     (0.206 vs 0.236 sec)
         array_ineg  ***  10% faster than ***  array_back      (0.210 vs 0.232 sec)
           var_func  ***   6% faster than ***  var_script      (0.167 vs 0.176 sec)
         var_script  ***  35% faster than ***  var_self        (0.176 vs 0.237 sec)
           iter_for  *** 119% faster than ***  iter_while      (0.115 vs 0.251 sec)
                ifs  ***  18% faster than ***  matches         (0.438 vs 0.518 sec)
     array_appendrw  ***   7% faster than ***  parray_appendrw (0.701 vs 0.749 sec)
       dontcallfunc  *** 216% faster than ***  callfunc        (0.115 vs 0.365 sec)
       inteval_auto  ***  55% faster than ***  inteval         (0.156 vs 0.243 sec)
     arrayeval_auto  *** 226% faster than ***  arrayeval       (0.157 vs 0.513 sec)
      dicteval_auto  *** 215% faster than ***  dicteval        (0.158 vs 0.499 sec)
      nulleval_auto  ***  53% faster than ***  nulleval        (0.159 vs 0.243 sec)
