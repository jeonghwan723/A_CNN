#!/bin/csh
# JHK

# function selection
setenv op_gpu     'on'

setenv exp_name   'v01_tr40'                     # experiment type
setenv h_dir '/home/jhkim/task/comp/A_CNN'       # Main directory

setenv n_gpu 0                        # GPU number
setenv n_ens 40                       # Ensemble number

foreach conv_f ( 35 )
foreach dens_f ( 50 )

setenv comb_name 'C'$conv_f'D'$dens_f

# test set
setenv test_inp  'godas.input.1980_2017.nc'
setenv test_lab  'godas.label.1980_2017.nc'

##############################################################################

echo 'Experiment: '$exp_name

@ ens = 1
while ( $ens <= $n_ens )

echo '  Ensemble: '$ens'/'$n_ens

mkdir -p $h_dir/output/$exp_name/$comb_name/src
mkdir -p $h_dir/output/$exp_name/$comb_name/EN$ens

cd $h_dir/output/$exp_name/$comb_name/src
cp -f $h_dir/sample/heatmap.sample ./heatmap.sample
cp -f $h_dir/sample/ensmean.heatmap.sample ./ensmean.sample

# Run
sed "s#h_dir#$h_dir#g"                   heatmap.sample > tmp1
sed "s/exp_name/$exp_name/g"                       tmp1 > tmp2
sed "s/ensemble/$ens/g"                            tmp2 > tmp1
sed "s#test_inp#$test_inp#g"                       tmp1 > tmp2
sed "s#test_lab#$test_lab#g"                       tmp2 > tmp1
sed "s/option_gpu/$op_gpu/g"                       tmp1 > tmp2
sed "s/conv_f/$conv_f/g"                           tmp2 > tmp1
sed "s/dens_f/$dens_f/g"                           tmp1 > tmp2
sed "s/comb_name/$comb_name/g"                     tmp2 > tmp1
sed "s/gpu_number/$n_gpu/g"                        tmp1 > heatmap.py
python heatmap.py

@ ens = $ens + 1
end

end
end

# ensemble mean
sed "s#h_dir#$h_dir#g"         ensmean.sample > tmp1
sed "s/exp_name/$exp_name/g"             tmp1 > tmp2
sed "s/comb_name/$comb_name/g"           tmp2 > tmp1
sed "s/n_ens/$n_ens/g"                   tmp1 > ensmean.py
python ensmean.py

