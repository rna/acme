# Acme Widget Co. Sales System

This project is a proof-of-concept for a sales basket system, implemented in plain Ruby to calculate the total cost of a basket of products, including delivery charges and special offers.

## Running the Application

This is a command-line application where the core logic is validated through a Minitest test suite.

### Prerequisites

- Ruby (> 3.0)

### Running the Tests

To run the tests, execute the following command from the project's root directory:

```sh
ruby test/basket_test.rb
```

## Design Philosophy

The solution was built using a **Test-Driven Development (TDD)** workflow. The architecture is designed to be clean, extensible, and maintainable by adhering to **SOLID principles**.


## Key Assumptions

- **Currency Truncation:** Based on the provided examples (e.g., `$54.375` becoming `$54.37`), the final total is **truncated** to two decimal places, not rounded to the nearest cent. This is handled via the `.floor(2)` method.
