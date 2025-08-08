let
  inherit (builtins)
    div
    mod
    foldl'
    abs
    length
    ;
in
rec {
  add = (a: (b: a + b));
  sub = (a: (b: a - b));
  mul = (a: (b: a * b));

  div_ = (a: (b: if b == 0 then throw "zero div error" else div a b));
  mod_ = (a: (b: mod a b));

  pow = base: exponent: if exponent == 0 then 1 else base * (pow base (exponent - 1));
  factorial = n: if n <= 1 then 1 else n * factorial (n - 1);
  # HCF == highest common factor (greatest common divisor)
  hcf = (a: (b: if b == 0 then a else hcf b (mod a b)));
  lcm = a: b: (abs (a * b)) / (hcf a b);

  listLcm = ns: foldl' lcm 1 ns;

  sum = ns: foldl' (add) 0 ns;
  product = ns: foldl' (mul) 0 ns;
  mean_avg = ns: if length ns == 0 then 0 else div_ (sum ns) (length ns); # mean avg returned as integer

	sqrt = n:
  let
    iterate = guess:
      let
        next = div (guess + div n guess) 2;
      in
        if abs (next - guess) <= 1 then
          if next * next > n then next - 1 else next
        else
          iterate next;
  in
    if n < 0 then throw "sqrt: negative number not allowed"
    else if n == 0 then 0
    else iterate (div n 2);
}
