```k
syntax Int ::= "removeStopped"  [function]
rule removeStopped  => 115792089237316195423570984636004990333889740523700931696805413995650331181055   [macro]
// 0xffffffffffffffffffffff00ffffffffffffffffffffffffffffffffffffffff

rule (removeStopped &Int ((B *Int pow160) +Int A)) => A
  requires #rangeAddress(A)
  andBool #rangeUInt(8, B)

//rule (pow160 |Int ((B *Int pow160) +Int A)) => B *Int pow160 +Int A
//  requires #rangeAddress(A)
//  andBool #rangeUInt(8, B)

````
