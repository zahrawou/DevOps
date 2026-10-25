# TP2 diagnosis (from the pipeline log only)

Team name used with the seed script: `devops-5ENG-FirstTeam`

| Defect | Gate that failed | Name in the log | One-line cause |
|---|---|---|---|
| Test 1 | tests | `tests/test_api.py::test_submitting_for_an_unknown_team_is_not_found` (fails by exception: `AttributeError: 'NoneType' object has no attribute 'id'`) | The code reads `.id` on `None` when the team does not exist, instead of answering "not found". |
| Test 2 | tests | `tests/test_scoring.py::test_last_solve_time_is_the_most_recent_not_the_last_added` (fails by assertion: `AssertionError`) | The function returns the last added solve (12:05) instead of the most recent one (12:30). |
| Credential | secret scan | `leaks found: 2` (the log does not print the rule or the file: gitleaks runs without `--verbose`) | Two strings that look like credentials are present in the files of the branch. |
| Dependency | dependency audit | `idna` 3.6: PYSEC-2024-60 and PYSEC-2026-215 | The pinned version of `idna` has known vulnerabilities; the fixes are in 3.7 and 3.15. |
