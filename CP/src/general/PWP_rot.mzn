include "globals.mzn";

int: w;
int: h;
int: n;
set of int: PACK = 1..n;
array[PACK] of int: p_width;
array[PACK] of int: p_height;

% Variables
array[PACK] of var int: x;
array[PACK] of var int: y;

% Handling rotation
array[PACK] of var bool: rot;
array[PACK] of var int: p_w = array1d(PACK, [if rot[i]==true then p_height[i] else p_width[i] endif | i in PACK]);
array[PACK] of var int: p_h = array1d(PACK, [if rot[i]==true then p_width[i] else p_height[i] endif | i in PACK]);


% Domain constraints
constraint forall(i in PACK)(x[i] >= 0);
constraint forall(i in PACK)(y[i] >= 0);
constraint forall(i in PACK)(x[i] <= w - p_w[i]);
constraint forall(i in PACK)(y[i] <= h - p_h[i]);

% Global constraints
constraint diffn(x, y, p_w, p_h);

% Implied constraints
constraint forall(i in 0..h)(sum(j in PACK where (y[j] <= i /\ y[j]+p_h[j] > i))(p_w[j]) <= w); 
constraint forall(i in 0..w)(sum(j in PACK where (x[j] <= i /\ x[j]+p_w[j] > i))(p_h[j]) <= h); 

% Handling pieces of same dimension
constraint forall(i, j in PACK where i<j)(if (p_w[i] == p_w[j] /\ p_h[i] == p_h[j]) then (x[j] >= x[i] + p_w[i] \/ y[j] >= y[i] + p_h[i]) endif);


solve satisfy;


% w = 11;
% h = 11;
% n = 7;
% p_width = [3, 3, 3, 3, 3, 5, 8];
% p_height = [3, 4, 5, 6, 5, 4, 4];

% w = 12;
% h = 12;
% n = 8;
% p_width = [3, 3, 3, 3, 3, 3, 3, 6];
% p_height = [3, 3, 6, 6, 6, 9, 9, 3];


