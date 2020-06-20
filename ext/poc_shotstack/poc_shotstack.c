#include "poc_shotstack.h"

VALUE rb_mPocShotstack;

void
Init_poc_shotstack(void)
{
  rb_mPocShotstack = rb_define_module("PocShotstack");
}
