# DSToken

```act
behaviour authority of DSToken
interface authority()

for all
  Authority : address

storage
  authority |-> Authority

iff
  VCallValue == 0

returns Authority
```

```act
behaviour owner of DSToken
interface owner()

for all
  Owner   : address
  Stopped : bool

storage
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  VCallValue == 0

returns Owner
```

```act
behaviour stopped of DSToken
interface stopped()

for all
  Owner   : address
  Stopped : bool

storage
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  VCallValue == 0

returns Stopped
```

```act
behaviour totalSupply of DSToken
interface totalSupply()

for all
  Supply : uint256

storage
  supply |-> Supply

iff
  VCallValue == 0

returns Supply
```

```act
behaviour balanceOf of DSToken
interface balanceOf(address usr)

for all
  BalanceOf : uint256

storage
  balances[usr] |-> BalanceOf

iff
  VCallValue == 0

returns BalanceOf
```

```act
behaviour allowance of DSToken
interface allowance(address src, address usr)

for all
  Allowance : uint256

storage
  allowance[src][usr] |-> Allowance

iff
  VCallValue == 0

returns Allowance
```

```act
behaviour symbol of DSToken
interface symbol()

for all
  Symbol : bytes32

storage
  symbol |-> Symbol

iff
  VCallValue == 0

returns Symbol
```

```act
behaviour decimals of DSToken
interface decimals()

for all
  Decimals : uint256

storage
  decimals |-> Decimals

iff
  VCallValue == 0

returns Decimals
```

```act
behaviour name of DSToken
interface name()

for all
  Name : bytes32

storage
  name |-> Name

iff
  VCallValue == 0

returns Name
```

```act
behaviour setAuthority of DSToken
interface setAuthority(address newAuthority)

for all
  Authority : address
  Owner     : address
  Stopped   : bool

storage
  authority       |-> Authority => newAuthority
  owner_stopped   |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  VCallValue == 0

if
  Owner == CALLER_ID
```

```act
behaviour setOwner of DSToken
interface setOwner(address newOwner)

for all
  Owner   : address
  Stopped : bool

storage
  owner_stopped   |-> #WordPackAddrUInt8(Owner, Stopped) => #WordPackAddrUInt8(newOwner, Stopped)

iff
  VCallValue == 0

if
  Owner == CALLER_ID
```

```act
behaviour start of DSToken
interface start()

for all
  Owner   : address
  Stopped : bool

storage
  owner_stopped   |-> #WordPackAddrUInt8(Owner, Stopped) => Owner

iff
  VCallValue == 0

if
  Owner == CALLER_ID
```

```act
behaviour stop of DSToken
interface stop()

for all
  Owner   : address
  Stopped : bool

storage
  owner_stopped   |-> #WordPackAddrUInt8(Owner, Stopped) => #WordPackAddrUInt8(Owner, 1)

iff
  VCallValue == 0

if
  Owner == CALLER_ID
```

```act
behaviour setName of DSToken
interface setName(bytes32 newName)

for all
  Owner   : address
  Stopped : bool

storage
  name            |-> _ => newName
  owner_stopped   |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  VCallValue == 0

if
  Owner == CALLER_ID
```

```act
behaviour approve of DSToken
interface approve(address usr, uint256 wad)

for all
  Allowed : uint256
  Stopped : bool
  Owner   : address

storage
  allowance[CALLER_ID][usr] |-> Allowed => wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  Stopped == 0
  VCallValue == 0

returns 1
```

```act
behaviour approve-max of DSToken
interface approve(address usr)

for all
  Allowed : uint256
  Stopped : bool
  Owner   : address

storage
  allowance[CALLER_ID][usr] |-> Allowed => maxUInt256
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  Stopped == 0
  VCallValue == 0

returns 1
```

```act
behaviour transfer of DSToken
interface transfer(address usr, uint256 wad)

for all
  Gem_c : uint256
  Gem_u : uint256
  Owner : address
  Stopped : bool

storage
  balances[CALLER_ID] |-> Gem_c => Gem_c - wad
  balances[usr]       |-> Gem_u => Gem_u + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_c - wad
  Gem_u + wad

iff
  Stopped == 0
  VCallValue == 0

if
  usr =/= CALLER_ID

returns 1
```

```act
behaviour transfer-self of DSToken
interface transfer(address usr, uint256 wad)

for all
  Gem_u : uint256
  Owner : address
  Stopped : bool

storage
  balances[usr] |-> Gem_u => Gem_u
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  wad <= Gem_u
  Stopped == 0
  VCallValue == 0

if
  usr == CALLER_ID

returns 1
```

```act
behaviour transferFrom of DSToken
interface transferFrom(address src, address dst, uint wad)

for all
  Gem_s     : uint256
  Gem_d     : uint256
  Allowance : uint256
  Owner     : address
  Stopped   : bool

storage
  allowance[src][CALLER_ID] |-> Allowance => #if (src == CALLER_ID or Allowance == maxUInt256) #then Allowance #else Allowance - wad #fi
  balances[src] |-> Gem_s => Gem_s - wad
  balances[dst] |-> Gem_d => Gem_d + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_s - wad
  Gem_d + wad

iff
  (Allowance == maxUInt256 or src == CALLER_ID) or (wad <= Allowance)
  VCallValue == 0
  Stopped == 0

if
  src =/= dst

returns 1
```

```act
behaviour transferFrom-self of DSToken
interface transferFrom(address src, address dst, uint wad)

for all
  Gem_s     : uint256
  Allowance : uint256
  Owner     : address
  Stopped   : bool

storage
  allowance[src][CALLER_ID] |-> Allowance => #if (src == CALLER_ID or Allowance == maxUInt256) #then Allowance #else Allowance - wad #fi
  balances[src] |-> Gem_s => Gem_s
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_s - wad

iff
  (Allowance == maxUInt256 or src == CALLER_ID) or (wad <= Allowance)
  VCallValue == 0
  Stopped == 0

if
  src == dst

returns 1
```

```act
behaviour push of DSToken
interface push(address usr, uint256 wad)

for all
  Gem_c : uint256
  Gem_u : uint256
  Owner : address
  Stopped : bool

storage
  balances[CALLER_ID] |-> Gem_c => Gem_c - wad
  balances[usr]       |-> Gem_u => Gem_u + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_c - wad
  Gem_u + wad

iff
  Stopped == 0
  VCallValue == 0

if
  usr =/= CALLER_ID
```

```act
behaviour push-self of DSToken
interface push(address usr, uint256 wad)

for all
  Gem_u : uint256
  Owner : address
  Stopped : bool

storage
  balances[usr] |-> Gem_u => Gem_u
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff
  wad <= Gem_u
  Stopped == 0
  VCallValue == 0

if
  usr == CALLER_ID
```

```act
behaviour pull of DSToken
interface pull(address src, uint wad)

for all
  Gem_s     : uint256
  Gem_d     : uint256
  Allowance : uint256
  Owner     : address
  Stopped   : bool

storage
  allowance[src][CALLER_ID] |-> Allowance => #if (src == CALLER_ID or Allowance == maxUInt256) #then Allowance #else Allowance - wad #fi
  balances[src] |-> Gem_s => Gem_s - wad
  balances[CALLER_ID] |-> Gem_d => Gem_d + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_s - wad
  Gem_d + wad

iff
  (Allowance == maxUInt256) or (wad <= Allowance)
  VCallValue == 0
  Stopped == 0

if
  src =/= CALLER_ID
```

```act
behaviour pull-self of DSToken
interface pull(address src, uint wad)

for all
  Gem_s     : uint256
  Owner     : address
  Stopped   : bool

storage
  balances[src] |-> Gem_s => Gem_s
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_s - wad

iff
  VCallValue == 0
  Stopped == 0

if
  src == CALLER_ID
```

```act
behaviour move of DSToken
interface move(address src, address dst, uint wad)

for all
  Gem_s     : uint256
  Gem_d     : uint256
  Allowance : uint256
  Owner     : address
  Stopped   : bool

storage
  allowance[src][CALLER_ID] |-> Allowance => #if (src == CALLER_ID or Allowance == maxUInt256) #then Allowance #else Allowance - wad #fi
  balances[src] |-> Gem_s => Gem_s - wad
  balances[dst] |-> Gem_d => Gem_d + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_s - wad
  Gem_d + wad

iff
  (Allowance == maxUInt256) or (wad <= Allowance)
  VCallValue == 0
  Stopped == 0

if
  src =/= dst
  src =/= CALLER_ID
```

```act
behaviour mint of DSToken
interface mint(address dst, uint wad)

types
  Owner   : address
  Gem_d   : uint256
  Supply  : uint256
  Stopped : bool

storage
  balances[dst] |-> Gem_d  => Gem_d  + wad
  supply        |-> Supply => Supply + wad
  owner_stopped |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_d + wad
  Supply + wad

iff
  Stopped == 0
  VCallValue == 0

if
  Owner == CALLER_ID
  ACCT_ID =/= CALLER_ID
```

```act
behaviour mint-self of DSToken
interface mint(uint wad)

types
  Owner   : address
  Gem_d   : uint256
  Supply  : uint256
  Stopped : bool

storage
  balances[CALLER_ID] |-> Gem_d  => Gem_d  + wad
  supply              |-> Supply => Supply + wad
  owner_stopped       |-> #WordPackAddrUInt8(Owner, Stopped)

iff in range uint256
  Gem_d + wad
  Supply + wad

iff
  Stopped == 0
  VCallValue == 0

if
  Owner == CALLER_ID
  ACCT_ID =/= CALLER_ID
```

```act
behaviour burn of DSToken
interface burn(address src, uint wad)

types
  Gem_s     : uint256
  Supply    : uint256
  Allowance : uint256
  Stoppedd  : bool
  Owner     : address

storage
  allowance[src][CALLER_ID] |-> Allowance => #if (src == CALLER_ID or Allowance == maxUInt256) #then Allowance #else Allowance - wad #fi
  balances[src]             |-> Gem_s  => Gem_s  - wad
  supply                    |-> Supply => Supply - wad
  owner_stopped             |-> #WordPackAddrUInt8(Owner, Stoppedd)

iff in range uint256
  Gem_s  - wad
  Supply - wad

iff
  (src == CALLER_ID) or (Allowance == maxUInt256) or (wad <= Allowance)
  VCallValue == 0
  Stoppedd == 0

if
  CALLER_ID == Owner
  CALLER_ID =/= ACCT_ID
```

```act
behaviour burn-self of DSToken
interface burn(uint wad)

types
  Gem_s     : uint256
  Supply    : uint256
  Allowance : uint256
  Stoppedd  : bool
  Owner     : address

storage
  allowance[CALLER_ID][CALLER_ID] |-> Allowance => Allowance
  balances[CALLER_ID]             |-> Gem_s  => Gem_s  - wad
  supply                          |-> Supply => Supply - wad
  owner_stopped                   |-> #WordPackAddrUInt8(Owner, Stoppedd)

iff in range uint256
  Gem_s  - wad
  Supply - wad

iff
  VCallValue == 0
  Stoppedd == 0

if
  CALLER_ID == Owner
  CALLER_ID =/= ACCT_ID
```
