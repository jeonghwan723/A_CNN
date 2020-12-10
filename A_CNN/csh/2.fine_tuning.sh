#!/bin/csh
# JHK

# function selection
setenv op_train   'on'
setenv op_test    'on'
setenv op_ensmean 'on'
setenv op_gpu     'on'

setenv pre_model  'v01'                          # pre-trained model
setenv exp_name   'v01_tr40'                     # experiment name (new)
setenv h_dir '/home/jhkim/task/comp/A_CNN'       # Main directory

setenv n_gpu 0                                   # set GPU number
setenv n_ens 40                                  # number of Ensemble member

foreach conv_f ( 35 )
foreach dens_f ( 50 )

setenv comb_name 'C'$conv_f'D'$dens_f

# validation set
setenv val_inp   'soda.input.1871_1970.nc'
setenv val_lab   'soda.label.1871_1970.nc'

# test set
setenv test_inp  'godas.input.1980_2017.nc'
setenv test_lab  'godas.label.1980_2017.nc'

##############################################################################

echo 'Experiment: '$exp_name

# Number of ensemble
@ ens = 1
while ( $ens <= $n_ens )

echo '  Ensemble: '$ens'/'$n_ens

mkdir -p $h_dir/output/$exp_name/$comb_name/src
mkdir -p $h_dir/output/$exp_name/$comb_name/EN$ens

cd $h_dir/output/$exp_name/$comb_name/src
cp -f $h_dir/sample/fine_tuning.sample ./run.sample
cp -f $h_dir/sample/ensmean.sample ./ensmean.sample

# Run
if ( $op_train == 'on' | $op_test == 'on' ) then
sed "s#h_dir#$h_dir#g"                       run.sample > tmp1
sed "s/exp_name/$exp_name/g"                       tmp1 > tmp2
sed "s/ensemble/$ens/g"                            tmp2 > tmp1
sed "s/op_training/$op_train/g"                    tmp1 > tmp2
sed "s/op_testing/$op_test/g"                      tmp2 > tmp1
sed "s#val_inp#$val_inp#g"                         tmp1 > tmp2
sed "s#val_lab#$val_lab#g"                         tmp2 > tmp1
sed "s#test_inp#$test_inp#g"                       tmp1 > tmp2
sed "s#test_lab#$test_lab#g"                       tmp2 > tmp1
sed "s/option_gpu/$op_gpu/g"                       tmp1 > tmp2
sed "s/conv_f/$conv_f/g"                           tmp2 > tmp1
sed "s/dens_f/$dens_f/g"                           tmp1 > tmp2
sed "s/comb_name/$comb_name/g"                     tmp2 > tmp1
sed "s/pre_model/$pre_model/g"                     tmp1 > tmp2
sed "s/gpu_number/$n_gpu/g"                        tmp2 > run.py
python run.py
endif

@ ens = $ens + 1
end

# combination mean
if ( $op_ensmean == 'on' ) then
sed "s#h_dir#$h_dir#g"         ensmean.sample > tmp1
sed "s/exp_name/$exp_name/g"             tmp1 > tmp2
sed "s/comb_name/$comb_name/g"           tmp2 > tmp1
sed "s/n_ens/$n_ens/g"                   tmp1 > ensmean.py
python ensmean.py
endif

end
end

