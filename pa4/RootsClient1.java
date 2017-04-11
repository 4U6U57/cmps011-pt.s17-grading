
class RootsClient1 {
   public static void main (String args[]) {
      double C[] = {1, -2, 1};

      System.out.print("poly() test: ");
      if (Roots.poly(C, 1) == 0) {
         System.out.println("Passed");
      } else {
         System.out.println("Failed");
      }
   }
}
