function f(x) {
	function g() {
		x = x + 1;
		return x;
	}
	return g;
}

let h = f(2);
return h();