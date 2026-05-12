# Fuller_locoLab

Everything probably works.
A big update on Tuesday, May 12 at around 0:23am occurred where the commit changes are listed as "upload" or some default commit message. These were the following updates:
 - 'helper_functions' folder and all its functions were deleted.
 - The find_normalized_stride_length function was combined with the find_stride_length function, meaning that one function now returns both a stride length and normalized stride length matrix
 - All files except "scatterGroundSpeed_test", "scatterStrideLengthCadence_test", "calculate_ground_speeds", and "plot_ground_speeds" were updated so that they work with both left and right heel data, not just left heel data.


## Repo and code Organization
#### Folders: Hold various helper functions
  Computation Functions: Heavy calculation helper functions
  Locolab Files: Supposed to hold the data files, but those are too large to be held on github
  Plotting & Testing Functions: Plotting and data-displayer helper functions

#### NOT in Folders: Various driver functions
Each of these files have the following code: directory = "/Users/kefuller/Fuller_Locolab/";
Please change them to match your computer's organization: directory = "/Users/YOUR_username/YOUR_fileOfCode/";
