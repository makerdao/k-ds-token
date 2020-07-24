```k
syntax Int ::= "#WordPackAddrUInt8" "(" Int "," Int ")" [function]
// ----------------------------------------------------------
rule #WordPackAddrUInt8(A, B) => B *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

rule maxUInt160 &Int ((B *Int pow160) +Int A) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

rule ((B *Int pow160) +Int A) /Int pow160 => B
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

syntax Int ::= "notMaxUInt160"  [function]
rule notMaxUInt160  => 115792089237316195423570985007226406215939081747436879206741300988257197096960   [macro]
// 0xffffffffffffffffffffffff0000000000000000000000000000000000000000

rule notMaxUInt160 &Int ((B *Int pow160) +Int A) => B
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

rule A |Int B => B *Int pow160 +Int A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

rule A |Int (notMaxUInt160 &Int B) => A
  requires #rangeAddress(A)
  andBool #rangeAddress(B)

syntax Int ::= "removeStopped"  [function]
rule removeStopped  => 115792089237316195423570984636004990333889740523700931696805413995650331181055   [macro]
// 0xffffffffffffffffffffff00ffffffffffffffffffffffffffffffffffffffff

rule (removeStopped &Int ((B *Int pow160) +Int A)) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

rule pow160 |Int A => 1 *Int pow160 +Int A
  requires #rangeAddress(A)

rule (((B *Int pow160) +Int A) &Int maxUInt160) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

```
