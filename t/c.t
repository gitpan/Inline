
use lib 'lib';

use Test;

plan(1);

use soft;
use Inline;
use NativeCall;

# returns must be after inline?
sub a_plus_b( int, int ) is inline('C') returns int32 {'
#include <dlfcn.h>
#include <stdio.h>
	DLLEXPORT int a_plus_b (int a, int b) {
        void *fun  = dlopen("/usr/lib/x86_64-linux-gnu/libxml2.so", RTLD_NOW);
        void **obj = dlsym(fun, "xmlParserVersion");
        char *ptr = (char *)*obj;
        printf("%s\n", ptr);
        return 42;
	}
'}

my $a = a_plus_b( 7, 35 );
#~ say $a[0];
