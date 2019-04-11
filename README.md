This is the collection of customary written computer codes for parsing, analyzing and plotting of the behavioral data from the Functional Neural Circuit lab in Institute of Neuroscience, Chinese Academy of Sciences. 

Some of the codes depend on a external Java library to function, which could be found at 
>https://github.com/wwweagle/zmat


For starter,
>BehaviorParser/DNMS/stats_GLM.m

contains necessary code to parse the raw behavior data to a descriptive number matrix. The `filelist` parameter which is necessary can be generated from the zmat library with `Zmat.updateFilesList()` followed by `Zmat.listFiles()`. A few example filelist was included in the `dnmsfiles.mat`.


>BehaviorParser/DNMS/plotAllPerf.m

contains necessary code for plot figures using previously parsed number matrix. In the current release some commented-out codes are functional and should be uncommented for generating plots.

For the source code driving the behavior hardware (dsPIC MCU) setup, please refer to:
>https://github.com/wwweagle/PIC20Odor

For the behavioral data acquisition, please refer to:
>https://github.com/wwweagle/SerialJ

For ephys data analysis codes, please refer to:
>https://github.com/wwweagle/ephysParser

For the spk2fr dependence library, please refer to:
>https://github.com/wwweagle/spk2fr