/*
 *     
 *  IMAGE PROCESSING
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define pixel(i, j, n)  (((j)*(n)) +(i))
int B = 16;


/*read*/
void  readimg(char * filename,int nx, int ny, int * image){
  
   FILE *fp=NULL;

   fp = fopen(filename,"r");
   for(int j=0; j<ny; ++j){
      for(int i=0; i<nx; ++i){
         fscanf(fp,"%d", &image[pixel(i,j,nx)]);      
      }
   }
   fclose(fp);
}

/* save */   
void saveimg(char *filename,int nx,int ny,int *image){

   FILE *fp=NULL;
   fp = fopen(filename,"w");
   for(int j=0; j<ny; ++j){
      for(int i=0; i<nx; ++i){
         fprintf(fp,"%d ", image[pixel(i,j,nx)]);      
      }
      fprintf(fp,"\n");
   }
   fclose(fp);

}

/*invert*/
__global__ void invert(int* image, int* image_invert, int nx, int ny){
  int indx = threadIdx.x + blockIdx.x * blockDim.x;
  int indy = threadIdx.y + blockIdx.y * blockDim.y;
  if(indx>=0 && indx < nx){
    if(indy>=0 && indy < ny){
      image_invert[pixel(indx,indy,nx)] = 255 - image[pixel(indx,indy,nx)];
    }
  }
}

/*smooth*/
__global__ void smooth(int* image, int* image_smooth, int nx, int ny){
  int indx = threadIdx.x + blockIdx.x * blockDim.x;
  int indy = threadIdx.y + blockIdx.y * blockDim.y;
  
  if(indx >= 0 && indx < nx){
    if(indy >= 0 && indy < ny){
      if(indx == 0 || indy == 0 || indx == nx-1 || indy == ny-1){
        image_smooth[pixel(indx,indy,nx)] = 0;
      }
      else{
        image_smooth[pixel(indx,indy,nx)] =(image[pixel(indx-1,indy+1,nx)] + image[pixel(indx,indy+1,nx)] +image[pixel(indx+1,indy+1,nx)] + image[pixel(indx-1,indy,nx)] + image[pixel(indx,indy,nx)] + image[pixel(indx+1,indy,nx)] + image[pixel(indx-1,indy-1,nx)] + image[pixel(indx,indy-1,nx)] + image[pixel(indx+1,indy-1,nx)]);
	image_smooth[pixel(indx,indy,nx)] = (int) image_smooth[pixel(indx,indy,nx)] / 9;
        if(image_smooth[pixel(indx, indy, nx)] < 0){
          image_smooth[pixel(indx, indy, nx)] = 0;
        } else if (image_smooth[pixel(indx, indy, nx)] > 255){
          image_smooth[pixel(indx, indy, nx)] = 255;
        }
      }
    }
  }
}

/*detect*/
__global__ void detect(int* image, int* image_detect, int nx, int ny){
  int indx = threadIdx.x + blockIdx.x * blockDim.x;
  int indy = threadIdx.y + blockIdx.y * blockDim.y;
  
  if(indx>=0 && indx < nx){
    if(indy >= 0 && indy < ny){
      if(indx == 0 || indy == 0 || indx == nx-1 || indy == ny-1){
        image_detect[pixel(indx,indy,nx)] = 0;
      }
      else{
        image_detect[pixel(indx,indy,nx)] = image[pixel(indx-1,indy,nx)] + image[pixel(indx+1,indy,nx)] + image[pixel(indx,indy-1,nx)] + image[pixel(indx,indy+1,nx)] - 4 * image[pixel(indx,indy,nx)];
        if(image_detect[pixel(indx, indy, nx)] < 0){
          image_detect[pixel(indx, indy, nx)] = 0;
        } else if (image_detect[pixel(indx, indy, nx)] > 255){
          image_detect[pixel(indx, indy, nx)] = 255;
        }
      }
    }
  }
}

/*enhance*/
__global__ void enhance(int* image,int *image_enhance,int nx, int ny){
  int indx = threadIdx.x + blockIdx.x * blockDim.x;
  int indy = threadIdx.y + blockIdx.y * blockDim.y;
  
  if(indx >= 0 && indx < nx){
    if(indy >= 0 && indy < ny){
      if(indx == 0 || indy == 0 || indx == nx-1 || indy == ny-1){
        image_enhance[pixel(indx,indy,nx)] = 0;
      }
      else{
        image_enhance[pixel(indx,indy,nx)] = 5*image[pixel(indx,indy,nx)] -(image[pixel(indx-1,indy,nx)] +image[pixel(indx+1,indy,nx)] + image[pixel(indx,indy-1,nx)] + image[pixel(indx,indy+1,nx)]);
        if(image_enhance[pixel(indx, indy, nx)] < 0){
          image_enhance[pixel(indx, indy, nx)] = 0;
        } else if (image_enhance[pixel(indx, indy, nx)] > 255){
          image_enhance[pixel(indx, indy, nx)] = 255;
        }
      }
    }
  }   
}

/* Main program */
int main (int argc, char *argv[])
{
   int    nx,ny;
   char   filename[250];
   float runtime;
   cudaEvent_t start, stop;
   cudaEventCreate(&start);
   cudaEventCreate(&stop);

   /* Get parameters */
   if (argc != 4) 
   {
      printf ("Usage: %s image_name N M \n", argv[0]);
      exit (1);
   }
   sprintf(filename, "%s.txt", argv[1]);
   nx  = atoi(argv[2]);
   ny  = atoi(argv[3]);

   printf("%s %d %d\n", filename, nx, ny);

   /* Allocate CPU and GPU pointers */

   int*   image=(int *) malloc(sizeof(int)*nx*ny); 
   int*   image_invert  = (int *) malloc(sizeof(int)*nx*ny);  
   int*   image_smooth  = (int *) malloc(sizeof(int)*nx*ny);  
   int*   image_detect  = (int *) malloc(sizeof(int)*nx*ny);  
   int*   image_enhance = (int *) malloc(sizeof(int)*nx*ny); 

   int*   d_image, *d_image_invert, *d_image_smooth, *d_image_detect, *d_image_enhance;
   cudaMalloc((void **) &d_image, sizeof(int)*nx*ny); 
   cudaMalloc((void **) &d_image_invert, sizeof(int)*nx*ny); 
   cudaMalloc((void **) &d_image_smooth, sizeof(int)*nx*ny); 
   cudaMalloc((void **) &d_image_detect, sizeof(int)*nx*ny); 
   cudaMalloc((void **) &d_image_enhance, sizeof(int)*nx*ny);
  

   /* Read image and save in array imgage */
   readimg(filename,nx,ny,image);

   dim3 dimBlock(B,B,1);
   int dimgx = (nx+B-1)/B;
   int dimgy = (ny+B-1)/B;
   dim3 dimGrid(dimgx,dimgy, 1);

   cudaEventRecord(start);

   cudaMemcpy(d_image, image, sizeof(int)*nx*ny, cudaMemcpyHostToDevice);
   invert<<<dimGrid, dimBlock>>>(d_image, d_image_invert, nx, ny);
   smooth<<<dimGrid, dimBlock>>>(d_image, d_image_smooth, nx, ny);
   detect<<<dimGrid, dimBlock>>>(d_image, d_image_detect, nx, ny);
   enhance<<<dimGrid, dimBlock>>>(d_image, d_image_enhance, nx, ny);
   cudaMemcpy(image_invert, d_image_invert, sizeof(int)*nx*ny, cudaMemcpyDeviceToHost);
   cudaMemcpy(image_smooth, d_image_smooth, sizeof(int)*nx*ny, cudaMemcpyDeviceToHost);
   cudaMemcpy(image_detect, d_image_detect, sizeof(int)*nx*ny, cudaMemcpyDeviceToHost);
   cudaMemcpy(image_enhance, d_image_enhance, sizeof(int)*nx*ny, cudaMemcpyDeviceToHost);

   cudaEventRecord(stop);
   cudaEventSynchronize(stop);
   cudaEventElapsedTime(&runtime, start, stop);

   printf("Total time: %f\n", runtime);

   /* Save images */
   char fileout[255]={0};
   sprintf(fileout, "%s-inverse.txt", argv[1]);
   saveimg(fileout,nx,ny,image_invert);
   sprintf(fileout, "%s-smooth.txt", argv[1]);
   saveimg(fileout,nx,ny,image_smooth);
   sprintf(fileout, "%s-detect.txt", argv[1]);
   saveimg(fileout,nx,ny,image_detect);
   sprintf(fileout, "%s-enhance.txt", argv[1]);
   saveimg(fileout,nx,ny,image_enhance);

   /* Deallocate CPU and GPU pointers*/
   free(image);
   free(image_invert);
   free(image_smooth);
   free(image_detect);
   free(image_enhance);

   cudaFree(d_image);
   cudaFree(d_image_invert);
   cudaFree(d_image_smooth);
   cudaFree(d_image_detect);
   cudaFree(d_image_enhance);
}
