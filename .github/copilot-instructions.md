# GitHub Copilot Instructions for dbt Projects

## Purpose

This file provides guidance for GitHub Copilot when working in this dbt
project. Follow these conventions unless a more specific instruction in
a nested `copilot-instructions.md` file or repository documentation
takes precedence.

## Project Structure

Assume a conventional dbt project structure unless the repository
indicates otherwise:

``` text
.
├── dbt_project.yml
├── profiles.yml              # Usually local-only; do not commit credentials
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
├── seeds/
├── snapshots/
├── macros/
├── tests/
├── analyses/
├── packages.yml
└── README.md
```

Before making changes:

1.  Inspect `dbt_project.yml`.
2.  Inspect relevant model SQL, YAML, macros, and tests.
3.  Follow existing project conventions rather than introducing new
    patterns.
4.  Check package dependencies in `packages.yml` when package
    functionality is involved.
5.  Prefer small, focused changes.

## dbt Conventions

Use dbt-native patterns whenever possible.

-   Use `ref()` for dependencies between dbt models.
-   Use `source()` for raw or externally managed source tables.
-   Do not hard-code database, schema, or table names when a dbt
    reference is appropriate.
-   Use `var()` for configurable project values that belong in dbt
    variables.
-   Use `env_var()` for environment-specific configuration and secrets.
-   Keep environment-specific behavior in configuration rather than
    duplicating model SQL.
-   Do not put credentials, access tokens, passwords, or other secrets
    in SQL, YAML, Python, or configuration committed to Git.
-   Prefer incremental models when the dataset size or project design
    warrants them.
-   Preserve existing materialization strategies unless there is a
    documented reason to change them.
-   Use explicit column selection rather than `select *` in
    production-facing models when practical.
-   Use meaningful model and column names consistent with the existing
    project.

## SQL Style

Write SQL that is readable, deterministic, and maintainable.

Preferred conventions:

-   Use uppercase SQL keywords.
-   Use lowercase `snake_case` for model and column names unless the
    project uses another convention.
-   Use CTEs to organize complex transformations.
-   Give CTEs descriptive names.
-   Keep joins explicit and easy to audit.
-   Qualify columns when joins could create ambiguity.
-   Avoid unnecessary nested subqueries.
-   Avoid unnecessary repeated expressions.
-   Use comments to explain business logic, not obvious SQL syntax.
-   Preserve the SQL dialect used by the project's target adapter.

Example:

``` sql
WITH orders AS (

    SELECT
        order_id,
        customer_id,
        order_date,
        order_total

    FROM {{ ref('stg_orders') }}

),

customers AS (

    SELECT
        customer_id,
        customer_name

    FROM {{ ref('stg_customers') }}

)

SELECT
    orders.order_id,
    orders.customer_id,
    customers.customer_name,
    orders.order_date,
    orders.order_total

FROM orders

LEFT JOIN customers
    ON orders.customer_id = customers.customer_id
```

## Model Layers

Follow the project's existing modeling architecture. If the project uses
the common layered approach:

### Sources

Sources represent externally managed data.

-   Declare sources in YAML.
-   Use `source()` to reference source tables.
-   Add source freshness configuration when the project uses freshness
    checks.
-   Document important source assumptions.

### Staging

Staging models should generally:

-   Select from one source or closely related raw inputs.
-   Rename columns into project conventions.
-   Cast data types.
-   Normalize obvious source-specific representations.
-   Perform light cleaning.
-   Avoid complex business logic.

Prefer:

``` sql
SELECT
    id AS customer_id,
    created_at::timestamp AS created_at,
    email

FROM {{ source('raw', 'customers') }}
```

over embedding substantial business transformations in staging models.

### Intermediate

Intermediate models should:

-   Encapsulate reusable transformations.
-   Combine or reshape staging models.
-   Keep complex business logic out of final marts when practical.
-   Have names that communicate their purpose.

### Marts

Marts should:

-   Represent business-facing datasets.
-   Use stable, meaningful names.
-   Contain business logic that belongs at the presentation layer.
-   Be documented and tested.
-   Avoid exposing unnecessary raw-source implementation details.

## Seeds

When working with seeds:

-   Keep seed files small and appropriate for version-controlled
    reference data.
-   Do not use seeds for large operational datasets.
-   Configure seed schemas and quoting in `dbt_project.yml` or the
    project's established configuration.
-   Document important seed columns.
-   Test key constraints where appropriate.

Example configuration:

``` yaml
seeds:
  project_name:
    +schema: raw
```

Do not assume that a `+schema` setting should be added or changed
without checking the project's current schema conventions.

## Sources

Define sources in YAML rather than hard-coding raw table references in
model SQL.

Example:

``` yaml
version: 2

sources:
  - name: raw
    schema: raw
    tables:
      - name: customers
        description: Customer records received from the source system.
```

Reference them with:

``` sql
SELECT *
FROM {{ source('raw', 'customers') }}
```

## Documentation

Document models and important columns using YAML.

Example:

``` yaml
version: 2

models:
  - name: dim_customer
    description: One row per customer.

    columns:
      - name: customer_id
        description: Unique identifier for the customer.
        data_tests:
          - not_null
          - unique

      - name: created_at
        description: Timestamp when the customer record was created.
```

Keep descriptions concise and useful. Explain business meaning and
important assumptions.

## Testing

Add tests when they provide meaningful protection against incorrect
data.

Common tests include:

-   `not_null`
-   `unique`
-   `accepted_values`
-   relationships tests
-   custom data tests for business rules

Prioritize tests for:

-   Primary or natural keys.
-   Foreign keys.
-   Important dimensions and facts.
-   Critical business rules.
-   Fields used for joins.
-   Fields used for downstream reporting.

Do not add tests mechanically to every column. Tests should provide
useful failure signals.

## Macros

Use macros for reusable SQL logic.

-   Keep macros focused.
-   Give macros descriptive names.
-   Document non-obvious arguments.
-   Avoid macros when simple SQL is clearer.
-   Do not duplicate large blocks of SQL when a reusable macro is
    appropriate.
-   Preserve adapter compatibility when the project supports multiple
    databases.

## Jinja

Use Jinja only where it improves maintainability or enables dbt
functionality.

Preferred uses include:

-   `ref()`
-   `source()`
-   `config()`
-   `var()`
-   `env_var()`
-   Reusable macros
-   Controlled conditional logic
-   Controlled iteration over metadata

Avoid generating unnecessarily complicated SQL through Jinja.

## Configuration

Prefer project configuration over hard-coded behavior.

Check:

-   `dbt_project.yml`
-   model-level configuration
-   YAML configuration
-   profiles configuration
-   environment variables
-   package configuration

Do not modify `profiles.yml` to add credentials to the repository.

If the project uses environment variables such as `DBT_ENV_NAME`,
preserve the existing convention and verify how the value is consumed
before changing it.

## Incremental Models

When modifying an incremental model:

1.  Understand its existing materialization strategy.
2.  Preserve the existing unique key unless there is a documented reason
    to change it.
3.  Review the `is_incremental()` logic carefully.
4.  Ensure the incremental filter does not accidentally exclude updates.
5.  Consider late-arriving data.
6.  Consider full-refresh behavior.
7.  Keep the SQL valid for both initial creation and incremental
    execution.

Example:

``` sql
SELECT
    id,
    updated_at,
    value

FROM {{ ref('stg_source') }}

{% if is_incremental() %}

WHERE updated_at > (
    SELECT COALESCE(MAX(updated_at), '1900-01-01')
    FROM {{ this }}
)

{% endif %}
```

Do not copy this pattern blindly. The correct incremental strategy
depends on the source data and business requirements.

## Naming

Use consistent names throughout the project.

Common conventions include:

-   `stg_<source>_<entity>` for staging models.
-   `int_<purpose>` for intermediate models.
-   `dim_<entity>` for dimensions.
-   `fct_<process>` for facts.
-   `src_<name>` for source-related models when that convention is
    already established.

Do not rename existing models solely to conform to a convention unless
the change is explicitly requested.

## Dependencies

When adding or changing dependencies:

-   Update `packages.yml` when a dbt package is required.
-   Do not manually copy package code into the repository unless the
    project explicitly requires it.
-   Use the package versioning conventions already established by the
    project.
-   Check compatibility with the project's dbt version and adapter.

## Version Control

Do not commit:

-   Credentials.
-   API keys.
-   Passwords.
-   Private certificates.
-   Local database files unless explicitly required.
-   Virtual environments.
-   Generated artifacts.
-   `target/`.
-   `dbt_packages/` unless the project explicitly tracks them.

Follow the repository's `.gitignore`.

Keep commits and changes focused. Avoid unrelated formatting changes.

## Validation

After making changes, validate them with the least expensive appropriate
checks first.

Typical sequence:

``` bash
dbt parse
dbt compile
dbt build --select <modified_models>
```

Use the project's documented commands when they differ.

For targeted changes, prefer targeted validation rather than rebuilding
the entire project unnecessarily.

When possible, verify:

1.  YAML syntax.
2.  dbt parsing.
3.  SQL compilation.
4.  Relevant model tests.
5.  Relevant data tests.
6.  Full project build when the change has broad impact.

Do not claim that a command succeeded unless it was actually run and the
result is known.

## DuckDB and Local Development

If the project uses DuckDB:

-   Respect the project's configured DuckDB database path.
-   Avoid committing local `.duckdb` database files unless explicitly
    required.
-   Prefer reproducible dbt commands over manual modifications to the
    DuckDB database.
-   Use the project's configured profile and target.
-   Do not assume Snowflake, Postgres, BigQuery, or another SQL dialect
    is available when DuckDB is the target.
-   Check adapter-specific SQL before introducing functions that may not
    be supported.

## Environment Configuration

Separate development and production configuration.

Do not hard-code:

-   Development database names.
-   Production database names.
-   User-specific schemas.
-   Credentials.
-   Local filesystem paths.

Use the project's established configuration mechanisms.

When an environment variable is used to determine a schema, database,
target, or other setting, inspect both the profile and project
configuration before changing its value or meaning.

## Error Handling and Debugging

When diagnosing a dbt error:

1.  Identify the exact command that failed.
2.  Read the complete error message.
3.  Determine whether the failure occurs during parsing, compilation,
    execution, or testing.
4.  Inspect the relevant configuration and dependency chain.
5.  Make the smallest change that addresses the root cause.
6.  Re-run the smallest useful validation command.
7.  Avoid speculative configuration changes.

Common categories include:

-   Profile resolution errors.
-   Adapter configuration errors.
-   YAML parsing errors.
-   Jinja compilation errors.
-   SQL dialect errors.
-   Missing dependencies.
-   Source configuration errors.
-   Schema or database permission errors.
-   Test failures.

## Changes to Existing Code

When modifying an existing model:

-   Preserve existing behavior unless the requested change requires
    otherwise.
-   Avoid unnecessary refactoring.
-   Do not rename columns or models without checking downstream
    references.
-   Check dependent models when changing a model's interface.
-   Update documentation and tests when behavior changes.
-   Explain breaking changes clearly.

## Pull Requests

A dbt pull request should generally include:

-   What changed.
-   Why it changed.
-   Models or macros affected.
-   Tests added or modified.
-   Validation commands run.
-   Any known limitations or follow-up work.

Avoid unrelated changes in the same pull request.

## Copilot Behavior

When generating or modifying code:

1.  Read the surrounding code before proposing a change.
2.  Follow existing project conventions.
3.  Prefer simple dbt-native solutions.
4.  Reuse existing macros and utilities when appropriate.
5.  Do not invent tables, columns, sources, packages, macros, or
    business rules.
6.  Ask for clarification when a required business rule is ambiguous.
7.  Do not silently change model grain.
8.  Do not silently change data types.
9.  Do not silently change materialization strategy.
10. Do not introduce credentials or secrets.
11. Do not introduce dependencies without checking whether they are
    already available.
12. Keep changes narrowly scoped.
13. Include or update tests for meaningful behavior changes.
14. Validate generated SQL when possible.
15. Prefer correctness and maintainability over minimizing the number of
    lines.

## Priority of Instructions

When instructions conflict, use this order:

1.  Explicit user requirements.
2.  Repository-specific documentation and architecture decisions.
3.  More specific nested Copilot instruction files.
4.  Existing project conventions.
5.  This file's general conventions.
6.  General dbt best practices.

When uncertain, inspect the repository before making assumptions.
