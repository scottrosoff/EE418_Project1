% Scott Rosoff

SMA = SMAuthProtocol();
r1_prime = generateRandBitString(SMA.l);
[SMA, M1_prime, M2_prime] = initiateAsReader(SMA, r1_prime);
[SMA, r1] = initiateAsTag(SMA);
[SMA, accept] = continueAsTag(SMA, xorLongString(M1_prime, xorLongString(r1, r1_prime)), M2_prime);
