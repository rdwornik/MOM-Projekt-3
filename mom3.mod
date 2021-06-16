param satisfaction_ratio;
param epsilon;

set K;
set F;
set M;
set D;
set Z;

set fabric_magazine{F}, within M;
set client_supplier{D}, within K;

param cost{z in Z, d in D};
param satisfaction{k in K, d in D};
param magazine{m in M};
param fabric{f in F};
param demand{k in K};

var X{z in Z, d in D} , >= 0;

var Total_Dissatisfaction = 
	sum{d in D}(sum{c in client_supplier[d]}(X[c,d]*(10-satisfaction[c,d])));

var Total_Satisfaction = 
	sum{d in D}(sum{c in client_supplier[d]}(X[c,d]*satisfaction[c,d]));

var Total_Cost = 
	sum{z in Z}(sum{d in D}(X[z,d]*cost[z,d]));

minimize Total_Rate: Total_Cost;
subject to
one{f in F}:
	sum{z in Z}(X[z,f]) <= fabric[f];
two{m in M}:
	sum{f in F}(X[m,f]) <= magazine[m];
three{k in K}:
	sum{d in D}(X[k,d]) = demand[k];
four:
	Total_Satisfaction <= epsilon;
five{m in M}:
	sum{f in F}(X[m,f]) = sum{k in K}(X[k,m]);
six{m in M}:
	X[m,m] = 0;
seven{d in D}:
	sum{ k in (K diff client_supplier[d])}(X[k,d]) = 0;
eight{f in F}:
	sum{ m in (M diff fabric_magazine[f])}(X[m,f]) = 0;