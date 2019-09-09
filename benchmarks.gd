tool
extends Node
export(bool) var click_to_run setget run

var resultsfile : File
var startusec : int = 0
var elapsed : int = 0
var testvar1 : int = 0
var testvar2 : int = 0

func run(junk): # TODO include Godot version in file name
	resultsfile = File.new()
	if resultsfile.open("res://timedresults.txt", File.WRITE) != 0:
		print("ERROR OPENING FILE")
		return
	print("\nSTARTING TIMED FUNCS")
	timeit("warmup")
	compare_funcs_time("array_resizereplace", "array_append")
	compare_funcs_time("vars_local_to_func", "vars_local_to_script")
	compare_funcs_time("vars_local_to_script", "selfvars_local_to_script")
	#resultsfile.store_string("adsf\nfda")
	resultsfile.close()
	

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
	timeit(funcname1, true)
	var elapsed1 = elapsed
	timeit(funcname2, true)
	var elapsed2 = elapsed
	var e1_over_e2 = float(elapsed1)/float(elapsed2)
	var fasterfunc
	var slowerfunc
	var slower_over_faster
	if elapsed1 > elapsed2:
		fasterfunc = funcname2
		slowerfunc = funcname1
		slower_over_faster = float(elapsed1)/float(elapsed2)
	else:
		fasterfunc = funcname1
		slowerfunc = funcname2
		slower_over_faster = float(elapsed2)/float(elapsed1)
	var result = "'%s' %.0f%% faster than '%s'" % [fasterfunc, 100.0*(slower_over_faster-1), slowerfunc]
	print(result)
	resultsfile.store_string("%s\n" % result)

func warmup():
	pass

func array_append():
	var a : Array = []
	var x : int = 0
	var i : int = 0
	while i < 500:
		a = []
		x = 0
		while x < 500:
			a.append(x)
			x += 1
		i += 1

func array_resizereplace():
	var a : Array = []
	var x : int = 0
	var i : int = 0
	while i < 500:
		a = []
		x = 0
		a.resize(500)
		while x < 500:
			a[x] = x
			x += 1
		i += 1
		
func vars_local_to_script():
	var i : int = 0
	while i < 500:
		testvar1 = 0
		while testvar1 < 500:
			testvar2 = testvar1
			testvar1 += 1
		i += 1
	
func vars_local_to_func():
	var localvar1 : int = 0
	var localvar2 : int = 0
	var i : int = 0
	while i < 500:
		localvar1 = 0
		while localvar1 < 500:
			localvar2 = localvar1
			localvar1 += 1
		i += 1
		
func selfvars_local_to_script():
	var i : int = 0
	while i < 500:
		self.testvar1 = 0
		while self.testvar1 < 500:
			self.testvar2 = self.testvar1
			self.testvar1 += 1
		i += 1
