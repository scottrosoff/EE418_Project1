SMA = SMAuthProtocol();

%Your code goes here: simulate the tag impersonation attack of Cai,
%Li, Li, and Deng
[SMA, accept] = continueAsTag(SMA, xorLongString(M1_prime, xorLongString(r1, r1_prime)), M2_prime);
%Code written after the call to impersonateTag will be DELETED
