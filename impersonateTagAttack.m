% Scott Rosoff

SMA = SMAuthProtocol();

%simulate the tag impersonation attack of Cai,
%Li, Li, and Deng:


%%%%%% PHASE 1 %%%%%%%
% first, initiate tag as an adversary 
[SMA, r1_prime] = initiateAsTag(SMA);
% send r1' to the tag
%SMA.r1 = r1_prime;

% tag generates random string r2
r2 = generateRandBitString(SMA.l);

% find M1' and M2'
M1_prime = xorLongString(SMA.t, r2);
temp = [SMA.t xorLongString(r1_prime, r2)];
M2_prime = binHash(temp);

% Send M1' and M2' to adversary
adv_M1 = M1_prime;
adv_M2 = M2_prime;


%%%%%%%PHASE 2%%%%%%%%%
r1 = generateRandBitString(SMA.l);
M1 = xorLongString(M1_prime, r1);
M1 = xorLongString(M1, r1_prime);
M2 = M2_prime;



[SMA, accept] = continueAsTag(SMA, xorLongString(M1_prime, xorLongString(r1, r1_prime)), M2_prime);
%Code written after the call to impersonateTag will be DELETED
