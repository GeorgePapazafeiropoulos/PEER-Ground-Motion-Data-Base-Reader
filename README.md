# PEER-Ground-Motion-Data-Base-Reader
Read and resample earthquake record time histories from the Pacific Earthquake Engineering Research Center (PEER) Ground Motion Data Base

This package is used to read and resample earthquake record time histories from external ASCII files that can be downloaded from the Pacific Earthquake Engineering Research Center (PEER) Ground Motion Data Base, available at the following link:

https://ngawest2.berkeley.edu/users/sign_in?unauthenticated=true

and hosted by the University of California, Berkeley, CA. Initially the user must download an earthquake record suite from this website and save all ASCII files inside the folder 'Records' of this package. After downloading the various records from the above data base, this main script is run to load and resample the time history data of the ASCII files, assemble them in cell arrays and plot them. The time histories read in this example include displacement, velocity and acceleration, both for horizontal and vertical components of the earthquakes considered. After reading the time history data from an ASCII file, the time history data are resampled, i.e. the time step of the data is adjusted to a new value that is specified by the user.
