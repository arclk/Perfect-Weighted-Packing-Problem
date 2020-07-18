include "globals.mzn";

int: w;
int: h;
int: n;
set of int: PACK = 1..n;
array[PACK] of int: p_width;
array[PACK] of int: p_height;

% Variables
array[PACK] of var 0..w: x;
array[PACK] of var 0..h: y;

% Domain constraints
constraint forall(i in PACK)(x[i] <= w - p_width[i]);
constraint forall(i in PACK)(y[i] <= h - p_height[i]);

% Global constraint
constraint diffn(x, y, p_width, p_height);

% Implied constraints
constraint forall(i in 0..h)(sum(j in PACK where (y[j] <= i /\ y[j]+p_height[j] > i))(p_width[j]) <= w); 
constraint forall(i in 0..w)(sum(j in PACK where (x[j] <= i /\ x[j]+p_width[j] > i))(p_height[j]) <= h); 


solve satisfy;


% solve :: int_search(x++y, dom_w_deg, indomain_random)         
%       :: restart_luby(100)
%       satisfy;
      

% w = 8;
% h = 8;
% n = 4;
% p_width = [3, 3, 5, 5];
% p_height = [3, 5, 3, 5];

% w = 13;
% h = 13;
% n = 9;
% p_width = [3, 3, 3, 3, 3, 3, 4, 4, 7];
% p_height = [3, 4, 5, 6, 7, 8, 3, 4, 6];

% w = 29;
% h = 29;
% n = 24;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 15, 18, 20, 3, 4, 5, 6, 7, 9, 15, 18, 20, 4, 8, 17];

% w = 38;
% h = 38;
% n = 19;
% p_width = [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 24];
% p_height = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 3, 5, 6, 8, 11, 12, 15, 16, 38];

