% Scott Rosoff

SMA = SMAuthProtocol();

%Your code goes here: simulate the tag impersonation attack of Cai,
%Li, Li, and Deng

% first, adversary generates random string r1' and sends it to tag
r1_prime = 


[SMA, accept] = continueAsTag(SMA, xorLongString(M1_prime, xorLongString(r1, r1_prime)), M2_prime);
%Code written after the call to impersonateTag will be DELETED
