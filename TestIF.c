int main(int a,int b)
{
	int a=5;	
	int b=10;
	if (a==5){
		b=8;
	}
	if (b>9){
		a=2;
	}
}

AFC @1000 5
COP @0 @1000
AFC @1000 15
COP @1 @1000
AFC @1000 5
variable déjà déclarée
AFC @1000 2
COP @0 @1000
AFC @1000 5
COP @2 @1000
AFC @1000 21
COP @3 @1000

