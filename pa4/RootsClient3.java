
class RootsClient3 {
   public static void main (String args[]) {
      double C[] = {1, -2, 1};

      System.out.print("findRoot() test: ");
      double root = Roots.findRoot(C, 0, 2, Math.pow(10, -7));
      if (Math.abs(root - 1) < Math.pow(10, -3)) { // I subtract the expected root and see if the answer is close enough to zero
         System.out.println("Passed");
      } else {
         System.out.println("Failed");
      }
   }
}
