classdef SMAuthProtocol
    properties(SetAccess=private)
        t_tag
        s_new
        s_old
        t_new
        t_old
        running_protocol
        r1
        l
        r2
        s
        t
    end
    methods
        function SM = SMAuthProtocol()
            l = 160;
            SM.l = 160;
            SM.running_protocol = 0;
            %s = floor(2^l*rand(1));
            SM.s = generateRandBitString(l);
            SM.t = binHash(SM.s);
            SM.s_new = SM.s;
            SM.s_old = SM.s;
            SM.t_new = SM.t;
            SM.t_old = SM.t;
            SM.t_tag = SM.t;
        end
        
        function [SMA,M1, M2] = initiateAsReader(SMA,r)
            if(SMA.running_protocol == 1)
                disp('Error!  A protocol is already running!');
                M1 = -1;
                M2 = -1;
                return;
            end
            SMA.r2 = generateRandBitString(SMA.l);
            M1 = xorLongString(SMA.t_tag, SMA.r2);
            tCatNonce = [SMA.t_tag xorLongString(r,SMA.r2)];
            M2 = binHash(tCatNonce);
            %M2 = hash(tCatNonce, 'SHA-1');
            SMA.running_protocol = 1;
            SMA.r1 = r;
        end
        
        function [SMA,r, M1, M2, M3] = eavesdropBlockLast(SMA)
            if(SMA.running_protocol == 1)
                disp('Error!  A protocol is already running!');
                r = -1;
                M1 = -1;
                M2 = -1;
                M3 = -1;
                return;
            end
            SMA.r1 = generateRandBitString(SMA.l);
            r = SMA.r1;
            SMA.r2 = generateRandBitString(SMA.l);
            M1 = xorLongString(SMA.t, SMA.r2);
            tCatNonce = [SMA.t_tag xorLongString(SMA.r1, SMA.r2)];
            M2 = binHash(tCatNonce);
            
            %Now simulate the reader's actions
            M3 = xorLongString(SMA.s, circShiftRight(SMA.r2, SMA.l/2));
            M3 = xorLongString(SMA.s, circShiftRight(SMA.r2, SMA.l/2));
            SMA.s_new = xorLongString(circShiftLeft(SMA.s, SMA.l/4), xorLongString(circShiftRight(SMA.t_tag, SMA.l/4), xorLongString(SMA.r1, SMA.r2)));
            SMA.t_new = hash(SMA.s_new, 'SHA-1');
            SMA.t_old = SMA.t_tag;
        end
        
        function [SMA,accept] = continueAsReader(SMA,M3)
            s_test = xorLongString(M3, circShiftRight(SMA.r2, SMA.l/2));
            if(binHash(s_test) == SMA.t_tag)
                accept = 1;
            else
                accept = 0;
            end
            SMA.running_protocol = 0;
        end
        
        function [SMA, r] = initiateAsTag(SMA)
%             if(SMA.running_protocol == 1)
%                 disp('Error!  Protocol already running');
%                 r = -1;
%                 return;
%             end
            SMA.running_protocol = 1;
            SMA.r1 = generateRandBitString(SMA.l);
            r = SMA.r1;
        end
        
        function [SMA,accept] = continueAsTag(SMA,M1, M2)
            %Assumes first round of protocol has already occurred
            %temp1 = 2^SMA.l*SMA.t_old + bitxor(SMA.r1, bitxor(M1, hex2dec(SMA.t_old)));
            temp1 = [SMA.t_old xorLongString(SMA.r1, xorLongString(M1, SMA.t_old))];
            accept = 0;
            if(M2 == binHash(temp1))
                accept = 1;
            else
                %temp2 = 2^SMA.l*SMA.t_new + bitxor(SMA.r1, bitxor(M1, SMA.t_new));
                temp2 = [SMA.t_old xorLongString(SMA.r1, xorLongString(M1, SMA.t_old))];
                if(M2 == binHash(temp2))
                    accept = 1;
                end
            end
            SMA.running_protocol = 0;
        end
    end
end

