# Digital Pulp - PHP Pre-commit Hooks

Pre-commit scripts appropriate for *any* PHP project. These hooks are made as custom plugins under the [pre-commit](http://pre-commit.com/#new-hooks) git hook framework.

# Setup

See (Adding pre-commit plugins to your project)[https://pre-commit.com/#adding-pre-commit-plugins-to-your-project]

# Supported Hooks

## php-lint

```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-lint
```

A bash script that runs `php -l` against stage files that are php. Assumes `php` is a global executable command. Will exit when it hits the first syntax error.

## php-lint-all

```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-lint-all
```

A systems hook that just runs `php -l` against stage files that have the `.php` extension. Add the `args: [-s first]` in your `.pre-commit-config.yaml` to enable it to exit on the first error found.

## php-unit


```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-unit
```

A bash script that will run the appropriate phpunit executable. It will assume

  - Find the executable to run at either `vendor/bin/phpunit`, `phpunit` or `php phpunit.phar` (in that exact order).
  - There is already a `phpunit.xml` in the root of the repo

Note in its current state, it will run the whole PHPUnit test as along as `.php` file was committed.

## php-cs

```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1 -p]
```

Similar pattern as the php-unit hook. A bash script that will run the appropriate [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer) executable.

It will assume that there is a valid PHP Code Sniffer executable at these locations, `vendor/bin/phpcs`, `phpcs` or `php phpcs.phar` (in that exact order).

The `args` property in your hook declaration can be used for pass any valid PHP Code Sniffer arguments. In the example above, it will run PHP Code Sniffer against only the staged php files with the `PSR-1` and progress enabled.

## php-cbf

```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1 -p]
```
Similar pattern as the php-cs hook. A bash script that will run the appropriate [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer) executable and will try to fix errors if it can using phpcbf.

It will assume that there is a valid PHP Code Beautifier and Fixer executable at these locations, `vendor/bin/phpcbf`, `phpcbf` or `php phpcbf.phar` (in that exact order).

The `args` property in your hook declaration can be used for pass any valid PHP Code Sniffer arguments. In the example above, it will run PHP Code Sniffer against only the staged php files with the `PSR-1` and progress enabled.

If you have multiple standards or a comma in your `args` property, escape the comma character like so

```yaml
- repo: https://github.com/digitalpulp/pre-commit-php.git
  rev: 1.4.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: ["--standard=PSR1/,path/to/ruleset.xml", "-p"]
```

To install PHP Codesniffer (phpcs & phpcbf), follow the [recommended steps here](https://github.com/squizlabs/PHP_CodeSniffer#installation).

## php-cs-fixer
```yaml
-- repo: https://github.com/digitalpulp/pre-commit-php.git
   rev: 1.4.0
  hooks:
  - id: php-cs-fixer
    files: \.(php)$
    args: [--level=PSR2]
```
Similar pattern as the php-cs hook. A bash script that will run the appropriate [PHP Coding Standards Fixer](http://cs.sensiolabs.org/) executable and to fix errors according to the configuration. It accepts all of the args from the `php-cs-fixer` command, in particular the `--level`, `--config`, and `--config-file` options.

The tool will fail a build when it has made changes to the staged files. This allows a developer to do a `git diff` and examine the changes that it has made. Remember that you may omit this if needed with a `SKIP=php-cs-fixer git commit`.

## php-stan

Adds the (PHPStan)[https://phpstan.org/] tool.



```yaml
-- repo: https://github.com/digitalpulp/pre-commit-php.git
   rev: 1.4.0
  hooks:
  - id: php-stan
    files: \.(php)$
```

An `args` property in your hook declaration can be used for pass any valid PHPStan arguments.

## php-psalm

Adds the [PSalm](https://psalm.dev/) tool.



```yaml
-- repo: https://github.com/digitalpulp/pre-commit-php.git
   rev: 1.4.0
  hooks:
  - id: php-psalm
    files: \.(php)$
```

An `args` property in your hook declaration can be used for passing any valid Psalm arguments.
