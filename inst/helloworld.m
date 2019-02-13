## Copyright (C) 2009 Riccardo Corradini <riccardocorradini@yahoo.it>
## Copyright (C) 2012 Carlo de Falco
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} = helloworld ()
## This function demonstrates sending and receiving a string message over MPI.
## Each process will send a message to process with rank 0, which will then display it.
## To run this example, set the variables HOSTFILE and NUMBER_OF_MPI_NODES to appropriate values, 
## then type the following command in your shell:
## @example
## mpirun --hostfile $HOSTFILE -np $NUMBER_OF_MPI_NODES octave --eval 'pkg load mpi; helloworld ()'
## @end example
## @seealso{hello2dimmat,hellocell,hellosparsemat,hellostruct,mc_example,montecarlo,Pi} 
## @end deftypefn

function helloworld ()

  MPI_Init();
  CW = MPI_COMM_WORLD;
  
  my_rank = MPI_Comm_rank (CW);
  p = MPI_Comm_size (CW);

  ## Could be any number
  TAG = 1;

  message = "";
  if (my_rank != 0)
    message = sprintf ("aaaaGreetings from process: %d!", my_rank);
    ## rankvect is the vector containing the list of rank of destination process
    rankvect = 0;
    [info] = MPI_Send (message, rankvect, TAG, CW);    
  else
    for source = 1:p-1
      disp ("We are at rank 0 that is master etc..");
      [message, info] = MPI_Recv (source, TAG, CW);
      printf ("Message received from source %d\n", source);
      printf ("%s\n", message);
    endfor
  endif
  
  MPI_Finalize();

endfunction

%!demo
%! system ("mpirun --hostfile $HOSTFILE -np $NUMBER_OF_MPI_NODES octave -q --eval 'pkg load mpi; helloworld ()'");

