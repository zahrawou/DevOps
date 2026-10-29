# TP2 diagnosis (from the pipeline log only)

| Defect | Gate that failed | Name in the log | One-line cause |
|---|---|---|---|
| Test 1 | tests | tests/test_api.py::test_submitting_for_an_unknown_team_is_not_found (exception: AttributeError) | an unknown team gives None and the code reads .id on it without checking |
| Test 2 | tests | tests/test_scoring.py::test_last_solve_time_is_the_most_recent_not_the_last_added (assertion: AssertionError) | last_solve_time returns the last item in the list, not the latest timestamp |
| Credential | secret scan | rule github-pat, src/scoreboard/config.py line 44 | a GitHub personal access token is hardcoded in the config module |
| Dependency | dependency audit | idna 3.6, PYSEC-2024-60 and PYSEC-2026-215 | requirements.txt pins a vulnerable version of idna (fixed in 3.15) |

Note: the pipeline reported 2 findings in the secret scan, but only one (github-pat in config.py) could be reproduced locally on the branch; main alone is clean.
