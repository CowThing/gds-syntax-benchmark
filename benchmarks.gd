tool
extends Node
export(bool) var click_to_run setget run

var outfile : File
var startusec : int = 0
var elapsed : int = 0
var testvar : int = 0
var bigarray : Array = []

func fileinit():
	outfile = File.new()
	if outfile.open("res://README.md", File.WRITE) != 0:
		print("ERROR OPENING FILE")
		return
	for line in [
			"# GDScript Syntax Benchmarks",
			"",
			"Speed comparisons of various syntax alternatives within the GDScript language (Godot game engine).  All code is within [benchmarks.gd](benchmarks.gd), including funcs referenced in results table.",
			"",
			"```Godot version: %s```" % Engine.get_version_info()["string"],
			"",
			"## Results",
			""
			]:
		outfile.store_string("%s\n" % line)

func printwrite(s):
	print(s)
	outfile.store_string("%s\n" % s)

func run(junk): # TODO include Godot version in file name
	fileinit()
	bigarray = []
	bigarray.resize(1e6)
	timeit("warmup", true) # warmup
	compare_funcs_time("array_append", "array_index")
	compare_funcs_time("array_len", "array_size")
	compare_funcs_time("array_front", "array_izero")
	compare_funcs_time("array_back", "array_ineg")
	compare_funcs_time("var_script", "var_func")
	compare_funcs_time("var_script", "var_self")
	compare_funcs_time("iter_for", "iter_while")
	compare_funcs_time("matches", "ifs")
	compare_funcs_time("parray_appendrw", "array_appendrw")
	compare_funcs_time("dontcallfunc", "callfunc")
	compare_funcs_time("inteval", "inteval_auto")
	compare_funcs_time("arrayeval", "arrayeval_auto")
	compare_funcs_time("dicteval", "dicteval_auto")
	compare_funcs_time("nulleval", "nulleval_auto")
	outfile.close()

func assign_startusec():
	startusec = OS.get_ticks_usec()

func assign_elapsed():
	elapsed = OS.get_ticks_usec() - startusec # do this first for accuracy
	assert startusec != 0 # then check that startusec had been properly assigned
	startusec = 0 # reset startusec

func timeit(funcname, quiet=false):
	assign_startusec()
	call(funcname)
	assign_elapsed()
	if not quiet:
		print("%s took %d usec" % [funcname, elapsed])

func compare_funcs_time(funcname1, funcname2):
	for fn in [funcname1, funcname2]:
		assert len(fn) <= 15 # for padding output strings
	timeit(funcname1, true)
	var elapsed1 = elapsed
	timeit(funcname2, true)
	var elapsed2 = elapsed
	var e1_over_e2 = float(elapsed1)/float(elapsed2)
	var fasterfunc
	var slowerfunc
	var fasterelapsed
	var slowerelapsed
	if elapsed1 > elapsed2:
		fasterfunc = funcname2
		slowerfunc = funcname1
		fasterelapsed = elapsed2
		slowerelapsed = elapsed1
	else:
		fasterfunc = funcname1
		slowerfunc = funcname2
		fasterelapsed = elapsed1
		slowerelapsed = elapsed2
	var result = "%15s  *** %3.f%% faster than ***  %-15s (%.3f vs %.3f sec)" % [fasterfunc, 100.0*(float(slowerelapsed)/float(fasterelapsed) -1.0), slowerfunc, fasterelapsed/1e6, slowerelapsed/1e6]
	printwrite("    " + result)

func warmup():
	for i in range(1e6): pass

func array_append():
	var a : Array = []
	for i in range(1e6): a.append(0)

func array_index():
	var a : Array = []
	a.resize(1e6)
	for i in range(1e6): a[i] = 0
		
func array_len():
	for i in range(1e6): len(bigarray)
		
func array_size():
	for i in range(1e6): bigarray.size()

func array_front():
	for i in range(1e6): bigarray.front()
		
func array_izero():
	for i in range(1e6): bigarray[0]

func array_back():
	for i in range(1e6): bigarray.back()
		
func array_ineg():
	for i in range(1e6): bigarray[-1]

func var_script():
	for i in range(1e6):
		testvar # read
		testvar = 0 # write
	
func var_func():
	var localvar : int = 0
	for i in range(1e6):
		localvar # read
		localvar = 0 # write
		
func var_self():
	for i in range(1e6):
		self.testvar # read
		self.testvar = 0 # write

func iter_for():
	for i in range(1e6): pass
	
func iter_while():
	var i : int = 0
	while i < 1e6: i += 1

func matches():
	var x : int = 0
	for i in range(1e6):
		match x:
			1: pass
			2: pass
			_: pass

func ifs():
	var x : int = 0
	for i in range(1e6):
		if x == 1: pass
		elif x == 2: pass
		else: pass

func parray_appendrw():
	var pa : PoolIntArray = PoolIntArray([])
	var i : int = 0
	while i < 1e6:
		pa.append(i)
		pa[i] = pa[i]
		i += 1

func array_appendrw():
	var a : Array = []
	var i : int = 0
	while i < 1e6:
		a.append(i)
		a[i] = a[i]
		i += 1

func dontcallfunc():
	for i in range(1e6): pass

func passonce(): pass
func callfunc():
	for i in range(1e6): passonce()

func inteval():
	var x : int = 1
	for i in range(1e6):
		if x == 0: pass

func inteval_auto():
	var x : int = 0
	for i in range(1e6):
		if x: pass

func arrayeval():
	var a : Array = [1]
	for i in range(1e6):
		if a == []: pass

func arrayeval_auto():
	var a : Array = []
	for i in range(1e6):
		if a: pass
		
func dicteval():
	var d : Dictionary = {0:0}
	for i in range(1e6):
		if d == {}: pass

func dicteval_auto():
	var d : Dictionary = {}
	for i in range(1e6):
		if d: pass

func nulleval():
	var x : int = 0
	for i in range(1e6):
		if x == null: pass
	
func nulleval_auto():
	var x : int = 0
	for i in range(1e6):
		if x: pass