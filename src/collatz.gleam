import gleam/int
import gleam/io
import gleam/list
import gleam/otp/task

pub fn main() {
  let input = 21
  let assert Valid(t) = reverse_traverse(input, 1, [])
  let g = reverse_guess(input, 1, [])
  io.print("Traverse: ")
  print(t)
  io.print("Guess: ")
  print(g)
  let lt = collatz(t, 0)
  let lg = collatz(g, 0)
  io.print("Length: ")
  print(lt)
  io.print("        ")
  print(lg)
  assert lt == input
  assert lg == input
}

pub fn collatz(n, l) {
  case n {
    0 -> 0
    1 -> l
    _ if n % 2 == 0 -> collatz(n / 2, l + 1)
    _ -> collatz(3 * n + 1, l + 1)
  }
}

pub fn reverse_guess(n: Int, c: Int, l: List(Int)) -> Int {
  case n {
    0 -> c
    _ -> {
      case c > 1 && { c - 1 } % 3 == 0 && !list.contains(l, { c - 1 } / 3) {
        True -> reverse_guess(n - 1, { c - 1 } / 3, [c, ..l])
        False -> reverse_guess(n - 1, c * 2, [c, ..l])
      }
    }
  }
}

pub fn reverse_traverse(n: Int, c: Int, l: List(Int)) -> Sequence {
  case n {
    0 -> Valid(c)
    _ -> {
      let t =
        task.async(fn() {
          case list.contains(l, c * 2) {
            True -> Invalid
            False -> reverse_traverse(n - 1, c * 2, [c, ..l])
          }
        })
      case c > 1 && { c - 1 } % 3 == 0 && !list.contains(l, { c - 1 } / 3) {
        True -> {
          let o1 = reverse_traverse(n - 1, { c - 1 } / 3, [c, ..l])
          let o2 = task.await(t, 1000)
          case o1, o2 {
            Valid(i), Valid(j) -> Valid(int.min(i, j))
            Valid(i), Invalid -> Valid(i)
            Invalid, Valid(j) -> Valid(j)
            Invalid, Invalid -> Invalid
          }
        }
        False -> task.await(t, 1000)
      }
    }
  }
}

fn print(n: Int) {
  io.println(int.to_string(n))
}

pub type Sequence {
  Valid(Int)
  Invalid
}
