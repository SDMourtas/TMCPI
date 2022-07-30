# Time-Varying Minimum-Cost Portfolio Insurance
Minimum-cost portfolio insurance (MCPI) is a well-known investment strategy that tries to limit the losses a portfolio may incur as stocks decrease in price without requiring the portfolio manager to sell those stocks. This repository contains the time-varying MCPI (TMCPI) problem, which is defined as a time-varying linear programming (TVLP) problem. 
The purpose of this package is to solve online the continuous-time version of the TMCPI problem by using different error-correction neural networks (ENNs). These neural network (NN) solvers are the zeroing NN (ZNN), the linear-variational-inequality primal–dual NN (LVI-PDNN), and the simplified LVI-PDNN (S-LVI-PDNN). 
The main article used is the following:
*	V.N. Katsikis, S.D. Mourtas, T.E. Simos and D. Balios, "Portfolio Insurance through Error-Correction Neural Networks", (submitted)

# M-files Description
*	Main_TMCPI.m: the main function and parameters declaration
*	TMCPI.m: main procedure for the TVLP TMCPI problem
*	dataprep.m: return and insurance prices construction
*	problem.m: complementary function for the problem setup
*	problem2.m: complementary function for the problem setup
*	inputs.m: complementary function for the problem setup
*	linots.m: function for vectors' linear interpolation
* pchinots.m: time-series piecewise cubic Hermite interpolation of vectors-matrices
* sp.m: the piecewise polynomial of the cubic spline interpolant of vectors-matrices
* splinots.m: time-series cubic spline interpolation of vectors-matrices
* oomega.m: parameter for spliting the observations to the time periods
*	ZNN.m: the ZNN solver for the TVLP TMCPI problem
*	LVIPDNN.m: the LVIPDNN solver for the TVLP TMCPI problem
*	SLVIPDNN.m: the SLVIPDNN solver for the TVLP TMCPI problem
*	Poweromega.m: the projection operator used by the LVIPDNN and SLVIPDNN

# Installation
*	Unzip the file you just downloaded and copy the TMCPI directory to a location,e.g.,/my-directory/
*	Run Matlab/Octave, Go to /my-directory/TMCPI/ at the command prompt
*	run 'Main_TMCPI' (Matlab/Octave)

# Results
After running the Main_TMCPI.m file, the package outputs are the following:
*	The optimal portfolio of the selected TMCPI problem created by ENNs.
*	The time consumptions of ENNs and linprog.
*	The graphic illustration of the portfolio weights along with the portfolios insurance costs, payoff and the error between the ENNs and linprog.

# Environment
The TMCPI package has been tested in Matlab 2021a on OS: Windows 10 64-bit.
