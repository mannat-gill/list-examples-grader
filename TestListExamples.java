import static org.junit.Assert.*;
import org.junit.*;
import java.util.*;


//checking if the string contains letter a 
class containsA implements StringChecker {
  public boolean checkString(String s) { 
    return (s.indexOf('a')>-1); 
  }
}
//checking if a string is greater than 7
class greaterThan7 implements StringChecker {
  public boolean checkString(String s) { 
    return (s.length()>7); 
  }
}

public class TestListExamples {
  @Test 
  public void test_merge(){
    List<String> expected = new ArrayList<>(Arrays.asList("apple", "grapes", "kiwi", "melon", "orange"));
    List<String> list_1 = new ArrayList<>(Arrays.asList( "apple", "melon"));
    List<String> list_2 = new ArrayList<>(Arrays.asList("grapes", "kiwi", "orange"));
    List<String> result =  ListExamples.merge(list_1, list_2); 
    assertEquals(expected, result);
  }

  @Test
  public void test_filter_withContainsA(){
    List<String> input = new ArrayList<>(Arrays.asList("apple", "grapes", "kiwi", "melon", "orange"));
    List<String> expected = new ArrayList<>(Arrays.asList("apple", "grapes", "orange"));
    List<String> result =  ListExamples.filter(input, new containsA()); 
    assertEquals(expected, result);
  }
 //passed test !
  @Test
  public void test_filter_withLengthSmallerThan7(){
    List<String> input = new ArrayList<>(Arrays.asList("Kentucky", "Texas", "Alaska", "North Carolina", "Arizona"));
    List<String> expected = new ArrayList<>(Arrays.asList("Kentucky", "North Carolina"));
    List<String> result =  ListExamples.filter(input, new greaterThan7()); 
    assertEquals(expected, result);
  }

}
