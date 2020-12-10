# A_CNN
CNN based all-season ENSO forecast model

## Processes of the Nino3.4 prediction

   - Main training with CMIP5 data (csh/1.main_training.sh)
   
   - Fine Tuning with SODA data (reanalysis) (csh/2.fine_tuning.sh)
   
   - Heatmap analysis (csh/3.heatmap.sh)
   
## Data set (netCDF4)

   -  you can download data set here: 
   
   -  The data set consists of the following:
   
   
          (1) Training set for main training (CMIP5): 
          
              Input: [CMIP5_tr.input.1861_2001.nc]
              Label: [CMIP5_tr.label.1863_2003.nc]
       
          (2) validation set for main training (CMIP5):
          
              Input: [CMIP5_val.input.1861_2001.nc]
              Label: [CMIP5_val.label.1861_2001.nc]
   
          (3) Training set for fine tuning (SODA):
          
              Input: [soda.input.1871_1970.nc]
              Label: [soda.label.1871_1970.nc]

          (4) Test set (GODAS):
          
              Input: [godas.input.1980_2017.nc]
              Label: [godas.label.1980_2017.nc]
   
## Reference
Ham, Y. G., Kim, J. H. & Luo, J.-J. Deep learning for multi-year ENSO forecasts. Nature 573, https://doi.org/10.1029/2010JC006695 (2019).

## Requirement (python packages)

   -  Tensowflow (> version 2.0, https://www.tensorflow.org/install/)
   -  netCDF4
   -  numpy
   
## Basic tutorial: https://www.tensorflow.org/tutorials/
   
   
