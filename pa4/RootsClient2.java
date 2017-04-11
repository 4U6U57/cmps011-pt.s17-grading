
class RootsClient2 {
   public static void main (String args[]) {
      double C[] = {1, -2, 1};
      double D[] = {-2, 2};

      System.out.print("diff() test: ");
      double DIFF[] = Roots.diff(C);
      if (DIFF.length == D.length && DIFF[0] == D[0] && DIFF[1] == D[1]) {
         System.out.println("Passed");
      } else {
         System.out.println("Failed");
      }
   }
}
