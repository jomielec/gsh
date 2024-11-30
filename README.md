# Gleam Style sHell
## Contributing
Please check that your code builds by running:
```sh
gleam build
zig build
```
Please make sure your code passes test by running:
```sh
gleam test
zig test
```
Please make sure your code is formated by running:
```sh
gleam format --check
zig fmt --check src/*.zig
```
If it is not please run:
```sh
gleam format
zig fmt src/*.zig
```

<!--
# gsh


[![Package Version](https://img.shields.io/hexpm/v/gsh)](https://hex.pm/packages/gsh)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gsh/)


```sh
gleam add gsh@1
```
```gleam
import gsh

pub fn main() {
  // TODO: An example of the project in use
}
```

Further documentation can be found at <https://hexdocs.pm/gsh>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
-->