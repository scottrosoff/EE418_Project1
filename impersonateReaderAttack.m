% Scott Rosoff

SMA = SMAuthProtocol();
[SMA,r1, M1, M2, M3] = eavesdropBlockLast(SMA);
[SMA, accept] = continueAsReader(SMA, M3);
