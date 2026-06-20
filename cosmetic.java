public class Cosmetic {

    // 필드(Field) : 화장품의 정보
    String name;       // 제품명
    String brand;      // 브랜드
    int price;         // 가격


    // 생성자(Constructor) : 객체 생성 시 초기값 설정
    public Cosmetic(String name, String brand, int price) {
        this.name = name;
        this.brand = brand;
        this.price = price;
    }


    // 메서드(Method) : 기능
    public void showInfo() {
        System.out.println("화장품 정보");
        System.out.println("제품명 : " + name);
        System.out.println("브랜드 : " + brand);
        System.out.println("가격 : " + price + "원");
    }
}
