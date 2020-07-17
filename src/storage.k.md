### DSToken

```k
syntax Int ::= "#DSToken.authority" [function]
rule #DSToken.authority => 0

syntax Int ::= "#DSToken.owner_stopped" [function]
rule #DSToken.owner_stopped => 1

syntax Int ::= "#DSToken.supply" [function]
rule #DSToken.supply => 2

syntax Int ::= "#DSToken.balances" "[" Int "]" [function]
rule #DSToken.balances[A] => #hashedLocation("Solidity", 3, A)

syntax Int ::= "#DSToken.allowance" "[" Int "][" Int "]" [function]
rule #DSToken.allowance[A][B] => #hashedLocation("Solidity", 4, A B)

syntax Int ::= "#DSToken.symbol" [function]
rule #DSToken.symbol => 5

syntax Int ::= "#DSToken.decimals" [function]
rule #DSToken.decimals => 6

syntax Int ::= "#DSToken.name" [function]
rule #DSToken.name => 7
```
