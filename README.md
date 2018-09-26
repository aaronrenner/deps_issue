# Umbrella deps issue

This project reproduces a dependency issue that occurs in an umbrella project
when an app has a grand-child dependency that's only available in the test
environment.

## App layout

This umbrella app has the following dependency tree

```
  deps_issue (umbrella)
      |
    app_a
      |
    app_b
      |
 test_only_dep (env: :test)
```

## Issue

Steps to recreate the issue.

```
deps_issue master % rm -rf _build
deps_issue master % iex -S mix
Erlang/OTP 21 [erts-10.0.7] [source] [64-bit] [smp:8:8] [ds:8:8:10]
[async-threads:1] [hipe]

==> test_only_dep
Compiling 2 files (.ex)
Generated test_only_dep app
==> app_b
Compiling 2 files (.ex)
Generated app_b app
==> app_a
Compiling 2 files (.ex)
Generated app_a app
Interactive Elixir (1.7.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
BREAK: (a)bort (c)ontinue (p)roc info (i)nfo (l)oaded
       (v)ersion (k)ill (D)b-tables (d)istribution
^C%
deps_issue master % cd apps/app_a
app_a master % iex -S mix
Erlang/OTP 21 [erts-10.0.7] [source] [64-bit] [smp:8:8] [ds:8:8:10]
[async-threads:1] [hipe]

** (Mix) Could not start application test_only_dep: could not find application
file: test_only_dep.app
app_a master %
```

## Expected results

You should be able to start app_a in isolation after compiling the umbrella.
This issue is not present in elixir 1.6.6.
