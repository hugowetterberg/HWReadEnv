HWReadEnv
=========

HWReadEnv is a MIT-licensed utility class for reading the users real environment variables. You know, the ones that are set in .bash_profile and it's siblings. 

Rationale
---------

When querying for the environment variables through NSProcess -environment you get some watered-down default environment that doesn't include any modifications to PATH, EDITOR or any other environment variables that are customized for the users interactive shell sessions.

Solution
--------

HWReadEnv runs bash and feeds it a script that loads the environment as a interactive session would and then runs `printenv` to dump the environment variables. The output is then read and put in a easy to use NSDictionary. Paths in PATH can be split using +splitPath: or manually through NSString -componentsSeparatedByString:.

License
-------

HWReadEnv is MIT licensed, see LICENSE. But attribution is always nice, and it's always fun to hear from people who find my code useful.
