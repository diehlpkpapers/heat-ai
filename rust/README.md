### Compilation 

```bash
error[E0308]: mismatched types
  --> src/main.rs:38:31
   |
38 |                 heat_eqn_step(chunk, start, end);
   |                 ------------- ^^^^^ expected `&mut Vec<f64>`, found `&mut [{float}]`
   |                 |
   |                 arguments to this function are incorrect
   |
   = note: expected mutable reference `&mut Vec<f64>`
              found mutable reference `&mut [{float}]`
note: function defined here
  --> src/main.rs:15:4
   |
15 | fn heat_eqn_step(u: &mut Vec<f64>, start: usize, end: usize) {
   |    ^^^^^^^^^^^^^ ----------------

For more information about this error, try `rustc --explain E0308`.
error: could not compile `heat-ai` (bin "heat-ai") due to previous erro
```
