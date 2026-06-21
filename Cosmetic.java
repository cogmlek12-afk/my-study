public class Cosmetic {

    // 필드(Field)
    String name;
    String brand;
    int price;


    // 생성자(Constructor)
    public Cosmetic(String name, String brand, int price) {
        this.name = name;
        this.brand = brand;
        this.price = price;
    }


    // 메서드(Method)
    public void showInfo() {

        System.out.println("화장품 정보");
        System.out.println("제품명 : " + name);
        System.out.println("브랜드 : " + brand);
        System.out.println("가격 : " + price + "원");

    }
}
