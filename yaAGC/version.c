#define export __attribute__((visibility("default")))

export char*
version()
{
  return NVER;
}
